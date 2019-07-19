# Get the AOSP Ring on OneAndroid
# Should be a comment in the manifest in the form
# <!-- One_Android_Ring='1' -->

# save the official lunch command to aosp_lunch() and source it
tmp_lunch=`mktemp`
sed '/ lunch()/,/^}/!d'  build/envsetup.sh | sed 's/function lunch/function aosp_lunch/' > ${tmp_lunch}
source ${tmp_lunch}
rm -f ${tmp_lunch}


# Override lunch function to filter lunch targets
function lunch
{
	aosp_lunch $*

	rm -rf Android.mk
	local patch_folder=vendor/intel/utils/android_n/google_diff

    # Check if there is a list of files to parse and apply patches listed in them if any
	for file in `find $patch_folder -type f 2>/dev/null` ; do
		if [[ "$TARGET_PRODUCT" =~ $(basename $file) ]]; then
			echo "Applying patche(s) needed for $TARGET_PRODUCT"
         vendor/intel/utils/autopatch.py -f $file
         local ret=$?
         if [ $ret -ne 0 ]; then
				local files_with_issues="$files_with_issues $file"
         fi
         # If some patch does not apply create Android.mk to stop compilation.
         if [ -n "$files_with_issues" ]; then
				echo "\$(error \"[GOOGLE_DIFF] Some patches given to autopatch did not applied correctly in $files_with_issues.\") " > Android.mk
         fi
       fi
	done
}

# a small alias, to run mixin-update from anywhere in the tree.
function mixinup
{
    local T=$(gettop)
    (cd $T && ./device/intel/mixins/mixin-update $@)
}
