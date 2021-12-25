class Mind {}
class TA_VehicleInfo {}
class TA_Mind : Mind
{
  TA_Mind(TA_VehicleInfo@ vi)
  {
    VehicleInfo = vi;
  }
  TA_VehicleInfo@ get_VehicleInfo() const property { return m_VehicleInfo; }
  void set_VehicleInfo(TA_VehicleInfo@ info) property { @m_VehicleInfo = @info; }
  private TA_VehicleInfo@ m_VehicleInfo;
};
