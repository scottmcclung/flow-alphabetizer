#!/bin/bash

# Script to simplify the sfdx process of creating and deploying a metadata package
# from an SFDX project.  The script expects to be placed in the SFDX project root directory.
#
# Example usage:
#   sfdeploy <mode> <target> <tests>
#   sfdeploy test uat local
#   sfdeploy test uat all
#   sfdeploy test uat test1,test2,test3
#   sfdeploy live uat
#   sfdeploy live uat local
#   sfdeploy live uat test1,test2,test3
#
#
# Mode:
#   The script can run in 'test' or 'live' mode.
#     Test mode deploys the package with the checkonly flag and runs any specified tests.
#     Live mode deploys the package to the org and runs the specified test plan.
#
# Target:
#   The target refers to the alias of the sfdx org connection.
#
# Tests (optional):
#   There are 3 different test plans that can be run.  All, Local, or a comma separated list of test classes.
#     All: runs all tests in the org including managed package tests.
#     Local: runs all tests in the org excluding managed package tests.
#     List: runs the test classes you specify in a comma separated list. (no spaces) (e.g. test1,test2,test3)
#   Leaving this blank will run the platform default tests.
#
#

MD_OUTPUT_DIR='metadata_output'
MODE=""
TARGET=""
TEST=""

show_help() {
    echo "sfdeploy (test | live) <target> [(local | all | test1,test2,test3)]"
}

testlevel() {
    if [ -z "$1" ]; then
        echo ""
        return
    fi
    case $1 in
        local )     echo " -l RunLocalTests "
                    ;;
        all )       echo " -l RunAllTestsInOrg "
                    ;;
        * )         echo " -l RunSpecifiedTests -r $1 "
    esac
}

test_params() {
    echo " -c $(testlevel $1) "
}

live_params() {
    echo " $(testlevel $1) "
}

remove_old_output_directory() {
    if [ -e $MD_OUTPUT_DIR ] && [ -d $MD_OUTPUT_DIR ]; then
        rm -rf $MD_OUTPUT_DIR
        return 0
    fi
    return 1
}

build_output_directory() {
    mkdir $MD_OUTPUT_DIR
}

die() {
    echo $@; exit 1;
}

## Have required number of args?
if [ $# -lt 2 ]; then
    die $(show_help)
fi

## Validate mode
case $1 in
    test )                  PARAMS=$(test_params $3)
                            ;;
    live )                  PARAMS=$(live_params $3)
                            ;;
    * )                     die $(show_help)
esac
TARGET=$2
DEPLOY_COMMAND="sfdx force:mdapi:deploy -w 60 -d $MD_OUTPUT_DIR -u $TARGET $PARAMS"

## Set up package output directory
if [ -e $MD_OUTPUT_DIR ]; then
    echo "Cleaning up previous deployment data..."
    remove_old_output_directory || die "ERROR: Please check the output path configuration.  Is the output path pointing at an existing file?"
fi

echo "Creating the package output directory..."
build_output_directory || die "Unable to create output directory."

echo "Converting the SFDX source to a metadata package..."
sfdx force:source:convert -d $MD_OUTPUT_DIR || die "Unable to create the package."

echo "Deploying the package..."
$DEPLOY_COMMAND


