
namespace EditorHelpers
{
    bool _permissionChecked = false;
    bool _permission = false;
    bool HasPermission()
    {
#if TMNEXT
        if (!_permissionChecked)
        {
            _permission = Permissions::OpenSimpleMapEditor()
                        && Permissions::OpenAdvancedMapEditor()
                        && Permissions::CreateLocalMap();
        }
#else
        _permission = true;
#endif
        return _permission;
    }
}
