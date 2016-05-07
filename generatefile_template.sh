#!/bin/bash
#an example,touch a new test.txt file with some line.
cat <<EOF>test.txt
#one line
#two line
servername 8.8.8.8
EOF

#another example,append line in text.txt file
cat <<EOF>>test.txt
#just append a new line
EOF
