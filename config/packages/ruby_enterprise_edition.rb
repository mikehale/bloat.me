module RubyEnterpriseEditionVerifier
  def has_ruby_enterprise
    @commands << 'ruby -e "exit 1 unless GC.respond_to?(:copy_on_write_friendly=)"'
  end
end
Sprinkle::Verify.register(RubyEnterpriseEditionVerifier)

package :ruby_enterprise_edition, :provides => :ruby1_8_6 do
  description 'Ruby Enterprise Edition'
  # if on ubuntu 8.0.4 we could use: http://rubyforge.org/frs/download.php/50088/ruby-enterprise_1.8.6-20090113_i386.deb
  source "http://rubyforge.org/frs/download.php/50087/ruby-enterprise-1.8.6-20090113.tar.gz" do
    custom_install "./installer --auto /usr/local"
  end

  verify do
    has_ruby_enterprise
  end

  requires :ree_dependencies
  requires :build_essential
end

package :ree_dependencies do
  description 'Ruby Enterprise Edition Dependencies'
  apt %w(zlib1g-dev libssl-dev)
end