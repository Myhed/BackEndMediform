#!/bin/bash
AllUrlImg=$(cat ../../AllImageTwitchGames.json)
#echo $AllUrlImg | jq '.Games | length' 
#curl -XGET -I $AllUrlImg | \
# jq -R '[(inputs | split(":") ) as $key | [[$key] | transpose[] | {key:$key[0],value:$key[1]}] | from_entries]' | echo "result " $(jq -r 'if .[3]["content-type"] == " image/jpeg\r" then .[3]["content-type"] else "echo $1" end')


# echo $AllUrlImg | jq '.[][][] | map({ box_art_url })' | jq --slurp '.' 

arr=( $(jq -r '.[][][][]["box_art_url"]' ../../AllImageTwitchGames.json) )

for i in "${arr[@]}"
    do
        result=$(curl -XGET -I $i | \
        jq -R '[(inputs | split(":") ) as $key | [[$key] | transpose[] | {key:$key[0],value:$key[1]}] | from_entries]' | jq -r 'if .[3]["content-type"] == " image/jpeg\r" then "image/jpeg" else "text/html" end')
        echo $result
        if [ $result == "image/jpeg" ]
            then
                echo "status code 200 {imageUrl:$i}"
            else
            echo "Status code 400 " $i
        fi
    done
