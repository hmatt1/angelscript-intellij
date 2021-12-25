// Draw Distance

[Setting name="Enabled" category="Draw Distance" description="Apply changes (only in main menu)"]
bool Setting_ZClip_Enabled = false;

[Setting name="Profile" category="Draw Distance" description="How far can camera draw everything"]
ZClip Setting_ZClip = ZClip::Disabled;

[Setting name="Distance" category="Draw Distance" description="Draw distance in blocks (for custom profile)" min="1" max="1000"]
int Setting_ZClip_Distance = 10;

// Geometry Quality

[Setting name="Enabled" category="Level of Detail" description="Apply changes"]
bool Setting_GeometryQuality_Enabled = false;

[Setting name="Distance" category="Level of Detail" description="Lowers objects quality at higher distance" min="0.001" max="1000.000"]
float Setting_GeometryQuality_Distance = 0.001;

// enums

enum ZClip
{
    Disabled,
    Near,
    Medium,
    Far,
    Custom
}