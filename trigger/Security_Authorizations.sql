create or replace trigger emp_permit_changes
  before insert or update or delete on eba_demo_da_emp

declare 
  not_on_weekends exception;
  not_working_hours exception;
  pragma exception_init (not_on_weekends, -4097);
  pragma exception_init (not_working_hours, -4099);
  
begin
  -- checkeamos el dia
  if(to_char(system, 'day') = 'sabado' or to_char(system, 'day') = 'domingo') then
    raise not_on_weekends; 
  end if;
  
  --  Checkeamos que sea horario laboral (8am a 6pm)
  if(to_char(system, 'hh24') < 8 or to_char(system, 'hh24') > 18) then
    raise not_working_hours; 
  end if;
  
  exception 
    when not_on_weekends then
      raise_application_error(-20324, 'Might not change employee table during the weekend');
    when not_working_hours then
      raise_application_error(-20326, 'Might not change emp table during Nonworking hours');        
end;