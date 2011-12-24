module ApplicationHelper
  
  def footer
     raw("#{t('global.app_name')} #{bar_break} #{t('global.copyright')}  #{Time.now.year}")
  end  
  
  def title
     t('global.app_name')
  end
  
  def bar_break
    raw("&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;")
  end
  

end
