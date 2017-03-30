class Vampire

  @@coven = []
  @@vlad_num = 1
  @@night = true

  def self.create(name = nil)
    if @@night
      @@coven << Vampire.new(name)
    else
      return nil
    end
    @@coven[-1]
  end

  def self.sunrise
    @@night = false
    @@coven.each do |vampire|
      unless (vampire.in_coffin && vampire.drank_blood_today)
        @@coven.delete(vampire)
      end
    end
  end

  def self.sunset
    @@night = true
    @@coven.each do |vampire|
      vampire.age += 1
      vampire.in_coffin = false
      vampire.drank_blood_today = false
    end
  end

  def initialize(name = nil)
    if (name == nil)
      @name = "Vlad #{vlad_num}"
      @@vlad_num += 1
    else
      @name = name.to_s
    end
    @age = 0
    @in_coffin = false
    @drank_blood_today = false
  end

  def drink_blood
    @drank_blood_today = true
  end

  def go_home
    @in_coffin = true
  end
end