class Zombie

  @@horde = []
  @@plague_level = 10
  @@max_strength = 8
  @@max_speed = 5
  @@default_speed = 1
  @@default_strength = 3
  @@day = 0

  def self.all
    @@horde
  end

  def self.new_day
    dead = Zombie.some_die_off
    born = Zombie.spawn
    Zombie.increase_plague_level
    @@day += 1
    puts "Apocalypse report: day #{@@day - 1}:"
    puts "************************"
    puts "New zombies:..........#{born}"
    puts "Dead zombies:.........#{dead}"
    puts "Total zombies:........#{Zombie.all.size}"
    puts "Plague_level:.........#{@@plague_level}"
  end

  def self.some_die_off
    number = rand(11)
    number.times do
      @@horde.delete_at(rand(@@horde.size))
    end
    number
  end

  def self.spawn
    number = rand(@@plague_level + 1)
    number.times do
      @@horde << Zombie.new("Zom Zom", rand(@@max_speed + 1), rand(@@max_strength + 1))
    end
    number
  end

  def self.increase_plague_level
    @@plague_level = 10 + @@horde.size / 2
  end

  def self.deadliest_zombie
    deadliest = @@horde[0]
    @@horde.each do |zombie|
      if ((zombie.speed + zombie.strength) > (deadliest.speed + deadliest.strength))
        deadliest = zombie
      end
    end
    deadliest
  end

  attr_reader :speed
  attr_reader :strength

  def initialize(name, speed = @@default_speed, strength = @@default_strength)
    @name = name
    if ((speed.to_i >= 0) && (speed.to_i <= @@max_speed))
      @speed = speed
    end
    if ((strength.to_i >= 0) && (strength.to_i <= @@max_strength))
      @strength = strength
    end
    @birthday = @@day
  end

  def encounter(name = "You")
    if(self.outrun_zombie?)
      puts "You got away!"
    elsif(self.survive_attack?)
      @@horde << Zombie.new(name)
      puts "You got turned into zombie"
    else
      puts "You died."
    end
  end

  def outrun_zombie?
    rand(@@max_speed +1) > @speed
  end

  def survive_attack?
    rand(@@max_strength +1) > @strength
  end
end
