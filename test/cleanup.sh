vagrant destroy
for HOST in bind-master bind-slave-1 bind-slave-2 ; do
  ssh-keygen -R $HOST
done
