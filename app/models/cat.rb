class Cat < ActiveRecord::Base
  validates :birth_date,
    date: { on_or_before: lambda { Time.now } },
    presence: true
  validates :color,
    inclusion: { in: ['black', 'turquoise', 'maroon', 'orange','fuscia'] },
    presence: true
  validates :sex,
    inclusion: { in: ['M', 'F', '?'] },
    presence: true

    def age
      Time.now.year - Time.new(self.birth_date).year
    end



end
