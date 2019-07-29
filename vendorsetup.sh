# a small alias, to run mixin-update from anywhere in the tree.
function mixinup
{
    local T=$(gettop)
    (cd $T && ./device/intel/mixins/mixin-update $@)
}
