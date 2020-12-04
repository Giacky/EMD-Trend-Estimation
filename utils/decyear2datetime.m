% Convert dates formatted in decimal years (e.g. 2005.3) to datetime 
% (e.g. 20-Apr-2005)
% 
% INPUT:
% decyear: date in decimal year format
%
% OUTPUT: date in datetime format

function date = decyear2datetime(decyear)
  % get the year
  year = floor(decyear);
  
  % calculate how many days are in the year (365 or 366)
  year_days = datenum(year+1,1,1)-datenum(year,1,1);
  
  % multiply how many days there are in the year by the decimal values to
  % get the corresponding amount of days passed in the given year
  days = ceil(mod(decyear,1) .* year_days); 
  
  % add the amount of days passed to the start of the year
  date = datetime(year,1,1) + caldays(days);
end