df -h | awk '$5+0 > 80 {print $0}' | grep -v "loop"
