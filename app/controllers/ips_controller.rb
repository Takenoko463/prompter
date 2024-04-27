class IpsController < ApplicationController
  include IpsHelper
  def create
    ip = Ip.find_by(ip_md5_head8: current_ip_md5_head8)
    Ip.create(ip_md5_head8: current_ip_md5_head8) unless ip
    session[:current_ip_md5_head8] = current_ip_md5_head8
  end
end
