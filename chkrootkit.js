#!/usr/bin/nodejs
// This is sort of a crontab wrapper, able to run a binarie (e.g. chkrootkit) 
// and examine the output for suspicious things (e.g. INFECTED|Vulnerable) then
// email the result.
// Usage: nodejs chkrootkit.js
// Requirements: apt-get install nodejs chkrootkit

var MAILTO = "scistifmsrv1@groupes.epfl.ch";
var MAILSUBJECT = "[scistfmsrv1] Rapport de chkrootkit";
var BINTOSPAWN = "chkrootkit";
var REGEXP = "/INFECTED|Vulnerable/";

var child_process = require("child_process");

var child = child_process.spawn(BINTOSPAWN, {
    stdio: [ 'ignore', 'pipe', 'pipe' ],
});

var exitcode = 0;
var stdout = "", stderr = "";
child.stdout.on('data', function(data) {
    stdout += data;
    if (String(data).match(REGEXP)) {
        exitcode = 1;
    }
});

child.stderr.on('data', function(data) {
    stderr += data;
});

child.on('exit', function(code, signal) {
    code = code || exitcode;
    if (code) {
        var sendmail = child_process.spawn(
            "mail", [MAILTO, "-s", MAILSUBJECT],
            { stdio: [ 'pipe', 'ignore', 'ignore' ]}
        );
        sendmail.stdin.write(stdout);
        sendmail.stdin.write(stderr);
        sendmail.stdin.end();
        sendmail.on('exit', function() {
            process.exit(0);
        });
    } else {
        process.exit(0);
    }
});

