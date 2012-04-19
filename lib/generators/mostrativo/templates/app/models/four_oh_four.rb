class FourOhFour < ActiveRecord::Base

  def self.add_request(host, path, referer)
    request = find_by_host_and_path_and_referer(host, path, referer)
    if request.nil?
      request = FourOhFour.new
      request.host, request.path, request.referer = host, path, referer
      request.count = 1
    else
      request.count += 1
    end
    request.save
  end

  def self.find_all_or_by_path(name = nil, page = nil, per_page = nil)
    if !name.nil? && !name.blank?
       four_oh_fours = find(:all, :conditions => ["path LIKE ?", "%#{name}%"], :order => "created_at DESC")
     else
       four_oh_fours = find(:all, :order => "id DESC")
     end
     four_oh_fours = four_oh_fours.paginate :page => page, :per_page => per_page
  end

end

