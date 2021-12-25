CSystemConfigDisplay@ display = null;

dictionary defaults = {};

void ApplySettings()
{
	if (Setting_ZClip_Enabled) {
		switch(Setting_ZClip) {
			case ZClip::Disabled:
				display.ZClip = CSystemConfigDisplay::ECSystemConfigDisplay__EZClip::_ZClip_Disable;
				break;
			case ZClip::Near:
				display.ZClipAuto = CSystemConfigDisplay::ECSystemConfigDisplay__EZClipAuto::_ZClipAuto_Near;
			case ZClip::Medium:
				display.ZClipAuto = CSystemConfigDisplay::ECSystemConfigDisplay__EZClipAuto::_ZClipAuto_Medium;
			case ZClip::Far:
				display.ZClipAuto = CSystemConfigDisplay::ECSystemConfigDisplay__EZClipAuto::_ZClipAuto_Far;
				display.ZClip = CSystemConfigDisplay::ECSystemConfigDisplay__EZClip::_ZClip_Auto;
				break;
			case ZClip::Custom:
				display.ZClip = CSystemConfigDisplay::ECSystemConfigDisplay__EZClip::_ZClip_Fixed;
				display.ZClipNbBlock = Setting_ZClip_Distance;
				break;
		}
	} else {
		display.ZClip = CSystemConfigDisplay::ECSystemConfigDisplay__EZClip(defaults['ZClip']);
		display.ZClipAuto = CSystemConfigDisplay::ECSystemConfigDisplay__EZClipAuto(defaults['ZClipAuto']);
		display.ZClipNbBlock = int(defaults['ZClipNbBlock']);
	}

	if (Setting_GeometryQuality_Enabled) {
		display.GeomLodScaleZ = Setting_GeometryQuality_Distance;
	} else {
		display.GeomLodScaleZ = float(defaults['GeomLodScaleZ']);
	}
}

void SetDefaults()
{
	defaults.Set("ZClip", display.ZClip);
	defaults.Set("ZClipAuto", display.ZClipAuto);
	defaults.Set("ZClipNbBlock", display.ZClipNbBlock);
	defaults.Set("GeomLodScaleZ", display.GeomLodScaleZ);
}

void OnSettingsChanged()
{
	ApplySettings();
}

void Main()
{
	@display = GetApp().Viewport.SystemConfig.Display;
	SetDefaults();
	ApplySettings();
}