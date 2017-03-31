class Vampire

  @@coven = []
  @@dracula = @@coven[0]
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

  def self.dracula
    if !@@coven.include(@@dracula)
      return nil
    end
    @@dracula
  end

  def self.all
    @@coven
  end

  def self.sunrise
    if @@night
      @@night = false
      @@coven.delete_if do |vampire|
        !(vampire.in_coffin && vampire.drank_blood_today)
      end
      return true
    else
      return false
    end
  end

  def self.sunset
    if !@@night
      @@night = true
      @@coven.each do |vampire|
        vampire.age += 1
        vampire.in_coffin = false
        vampire.drank_blood_today = false
      end
      return true
    else
      return false
    end
  end

  attr_reader :name
  attr_accessor :age
  attr_accessor :drank_blood_today
  attr_accessor :in_coffin

  def initialize(name = nil)
    if (name == nil)
      @name = "Vlad #{@@vlad_num}"
      @@vlad_num += 1
    else
      @name = name.to_s
    end
    @age = 0
    @in_coffin = false
    @drank_blood_today = true
  end

  def drink_blood
    @drank_blood_today = true
  end

  def go_home
    @in_coffin = true
  end
end
