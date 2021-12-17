JET_LIST="jetpack-0 jetpack-1 jetpack-2 jetpack-3 jetpack-4"
REMOTE_CMD="sudo docker system prune -a -f"

if [ x"$1" != "x" ]; then
  REMOTE_CMD=$1
fi

for i in $JET_LIST; do
  echo $i
  ssh $i $REMOTE_CMD
done
