class Cat < ActiveRecord::Base

  COLORS = ['black', 'turquoise', 'maroon', 'orange','fuschia', 'white']

  validates :birth_date,
    timeliness: { on_or_before: lambda { Time.now } },
    presence: true

  validates :color,
    inclusion: { in: COLORS },
    presence: true

  validates :sex,
    inclusion: { in: ['M', 'F', '?'] },
    presence: true

  has_many :cat_rental_requests, ->{ order(:start_date) }, dependent: :destroy

  belongs_to :owner, class_name: "User"

  def age
    Time.now.year - self.birth_date.year
  end


end
