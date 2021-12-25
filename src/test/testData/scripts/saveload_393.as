class dummy
{
  bool set_callback(menu_callback@ callback, string user_data)
  {
    @callback_handle=@callback;
    callback_data=user_data;
    return true;
  }
  void do_something()
  {
    if(@callback_handle!=null)
    {
      int callback_result=callback_handle(this, callback_data);
    }
  }
  menu_callback@ callback_handle;
  string callback_data;
}
funcdef int menu_callback(dummy@, string);
void main()
{
}
