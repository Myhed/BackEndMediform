i=1

for i in `seq 7936 34282`
do
echo $(curl -H 'Client-ID: 985dk1r75f443pkghj88xmzi2pbqc0' -X GET "https://api.twitch.tv/helix/games?id=$i")",">> ./AllImageTwitchGames.json
done
