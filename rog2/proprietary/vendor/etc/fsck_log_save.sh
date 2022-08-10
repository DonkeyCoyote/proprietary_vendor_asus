#!/vendor/bin/sh

echo "[FSCK] Save fsck log to /asdf!!" > /dev/kmsg

# Copy fsck log to asdf
timestamp=`date +%Y%m%d-%H%M%S`

file_num=`ls -l /asdf | grep -o "f2fs" | wc -l`
echo "[FSCK] file_num $file_num" > /dev/kmsg

while [ $file_num -gt 5 ]
do
	file_num=`ls -l /asdf | grep -o "f2fs" | wc -l`
	echo "[FSCK] file_num $file_num" > /dev/kmsg

	oldest=`ls /asdf | grep "f2fs" | head -n 1`
	echo "[FSCK] rm /asdf/$oldest" > /dev/kmsg
	rm /asdf/$oldest
done

cp /dev/fscklogs/logf2fs /asdf/f2fs_log_$timestamp.txt
