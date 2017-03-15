# PhpStorm Scope Generator

Create PhpStorm scopes based on the files contained in a GitHub Pull request.

## Installation

- Clone this repository somewhere on your computer
- In your `~/.bash_profile`, add `export PHPSTORM_SCOPE_GENERATOR_TOKEN={token}`, where `{token}` is the value you have obtained from [creating an access token](https://github.com/settings/tokens/new) with "Repo" privileges.

## Usage

Note that this script won't check out the pull request branch for you. You need to do that first. Then run this script, which will generate a Scope in PhpStorm with a list of the changed files in the pull request.

``` bash
cd /path/to/git-repo
bash /path/to/scope-generator.sh {pull-request-url}
# In PhpStorm, "Inspect Code" and select the new scope
```

Specific example:

``` bash
cd /tmp
git clone git@github.com:savaslabs/sumac.git
bash /path/to/scope-generator.sh https://github.com/savaslabs/sumac/pull/15
# In PhpStorm, open `/tmp/sumac` and you will have a scope for pull request 15 available
```
