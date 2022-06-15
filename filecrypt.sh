#!/bin/bash
echo "SigmaCorp workspace encrypter"

if [ $2 == 'encrypt' ]
then 
        echo Compressing and encrypting files using tar and GPG.
        echo Do not worry about the warnings, they are completely normal
        tar -cz $1 | gpg -c -o encrypted.tgz.gpg

        echo Flushing GPG cache
        gpg-connect-agent reloadagent /bye

        if [ $3 == 'shred' ]
        then
            echo Shredding all files
            shred $1*
        fi
        echo Deleting files
        rm -rf $1

        echo done!

elif [ $2 == 'decrypt' ]
then
    echo Decrypting and extracting archive..
    gpg -d $1 | tar xz

    echo Flusing GPG cache
    gpg-connect-agent reloadagent /bye
    
    echo done!
else
    echo Something went wrong
fi
