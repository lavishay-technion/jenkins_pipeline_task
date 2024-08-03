##############

In /tmp/details_app/build.sh line 8:
 APP_VERSION=${1:'0.0.1'}
 ^---------^ SC2034 (warning): APP_VERSION appears unused. Verify use (or export if used externally).

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- APP_VERSION appears unused. Verif...

In /tmp/details_app/src/details/test.sh line 8:
if [[ 0 == 0 ]]
^-- SC1049 (error): Did you forget the 'then' for this 'if'?
^-- SC1073 (error): Couldn't parse this if expression. Fix to allow more checks.


In /tmp/details_app/src/details/test.sh line 10:
fi
^-- SC1050 (error): Expected 'then'.
  ^-- SC1072 (error): Unexpected keyword/token. Fix any mentioned problems and try again.

For more information:
  https://www.shellcheck.net/wiki/SC1049 -- Did you forget the 'then' for thi...
  https://www.shellcheck.net/wiki/SC1050 -- Expected 'then'.
  https://www.shellcheck.net/wiki/SC1072 -- Unexpected keyword/token. Fix any...
##############
