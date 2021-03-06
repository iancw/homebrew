require 'formula'

class Ssss < Formula
  url 'http://point-at-infinity.org/ssss/ssss-0.5.tar.gz'
  homepage 'http://point-at-infinity.org/ssss/'
  sha1 '3f8f5046c2c5c3a2cf1a93f0a9446681852b190e'

  depends_on 'gmp'
  depends_on 'xmltoman'

  def install
    inreplace 'Makefile' do |s|
      # Compile with -DNOMLOCK to avoid warning on every run on OS X.
      s.gsub! /\-W /, '-W -DNOMLOCK $(CFLAGS) $(LDFLAGS)'
      s.change_make_var! "CC", ENV.cc
    end

    ENV.append 'CFLAGS', "-I#{HOMEBREW_PREFIX}/include"
    system "make"
    man1.install %w{ ssss.1 }
    bin.install %w{ ssss-combine ssss-split }
  end
end
