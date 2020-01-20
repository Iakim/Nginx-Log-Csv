# Create a csv file of processing logs nginx/apache for graphs, like, X=hour, Y=hits and Legend line=IP

### Crontab

        00 01 * * * cd "/path/to/scripts" && sh nginx_toptwenty.sh
