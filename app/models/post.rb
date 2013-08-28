class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

	def self.display_data(page, sort)
		self.all
#		self.paginate(:page => page,
#				  :per_page => 10,
#				  :order => sort.nil? ? self.primary_key : sort)
#		#can also include :joins and :conditions
	end

end
