# Flow Alphabetizer

[![Deploy to SFDX](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com?template=https://github.com/nerdmagik/flow-alphabetizer)

[![Deploy to Salesforce](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com?owner=nerdmagik&repo=flow-alphabetizer)

Since there is currently no declarative solution to alphabetize strings in a Salesforce Flow, this provides an invokable method to enable alphabetical text comparisons in your flow.


### Installation
Use the 'Deploy to SFDX' button to install into a scratch org or use the 'Deploy to Salesforce' button to install into a sandbox or developer org.

### Use

After installation, the Alphabetizer node will be available in the APEX section of the flow designer palette.

#### Inputs

##### Comparator

This is the comparison test you want to make.
There are 6 options available.  They can be written out or you can use the shortcut forms.

* equals (shortcut: '=' or '==')
* less than (shortcut: '<')
* greater than (shortcut: '>')
* less than or equals (shortcut: '<=')
* greater than or equals (shortcut: '>=')
* between (shortcut: '><')

##### Text Value 1 and Text Value 2

For most comparisons, these represent the two text values to be compared.

Example:

* Text Value 1 = Text Value 2
* Text Value 1 < Text Value 2
* Text Value 1 > Text Value 2
* Text Value 1 <= Text Value 2
* Text Value 1 >= Text Value 2

##### Text Value 3

When using the 'between' comparator, use the optional Text Value 3 input to evaluate the following expression.

* Text Value 1 between Text Value 2 and Text Value 3


#### Outputs

##### Result

Result is the true/false result of the expression.

##### Success

A boolean result of whether the comparison was successfully completed.

##### Error Message

If the Success output is false, this output variable will contain the error message.
