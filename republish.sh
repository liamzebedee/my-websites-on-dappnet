# I put this in my crontab
# 
# crontab -e
# @daily /Users/liamz/Documents/Projects/dappnet/personal-dappsites/republish.sh

set -ex
ipfs name publish --key liamz         QmUbPLjPjiK8yL2jAVX7dLA6tmqDZR67t1Y5uTYgf2GKPA
ipfs name publish --key rollerskating Qmf7WcgsvAofPeXW7Vj7eFCKNU2xkYLaJEQkvRb3xT2hCQ