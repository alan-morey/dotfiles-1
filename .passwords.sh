#!/bin/sh

# Query passwords from the keychain.
# Create passwords as 'generic password':
# set 'keychain item name' to 'gmail.com'
# set 'account name' to the email address
# set 'password' to the password, duh.

MAIL_USERNAME_PRIVATE="arvid.gerstmann@gmail.com"
MAIL_PASSWORD_PRIVATE=$(security find-generic-password -a 'arvid.gerstmann@gmail.com' -l 'gmail.com' -w)

MAIL_USERNAME_APPICO="arvid.gerstmann@appico.com"
MAIL_PASSWORD_APPICO=$(security find-generic-password -a 'arvid.gerstmann@appico.com' -l 'gmail.com' -w)

MAIL_USERNAME_VOONY="arvid@voonygames.com"
MAIL_PASSWORD_VOONY=$(security find-generic-password -a 'arvid@voonygames.com' -l 'gmail.com' -w)

