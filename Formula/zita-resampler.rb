class ZitaResampler < Formula
  desc "C++ library for real-time resampling of audio signals (static lib)"
  homepage "http://kokkinizita.linuxaudio.org/linuxaudio/"
  url "http://kokkinizita.linuxaudio.org/linuxaudio/downloads/zita-resampler-1.8.0.tar.bz2"
  sha256 "e5744f23c54dd15b3f783a687bd879eee2a690a4545a15b49c4cf037aa464aa2"
  license "GPL-3.0-or-later"

  def install
    ENV.prepend "LDFLAGS", "-mmacosx-version-min=10.13"

    chdir "source" do
      inreplace "Makefile" do |s|
        s.gsub! "-march=native", "-pipe -mmacosx-version-min=10.13"
        s.gsub! "-soname", "-install_name"
        s.gsub! ".so", ".dylib"
        s.gsub! "ldconfig", "true"
      end
      system "make"
      system "ar", "qc", "libzita-resampler.a", *Dir["*.o"]
      system "ranlib", "libzita-resampler.a"
      include.install "zita-resampler"
      lib.install "libzita-resampler.a"
    end
  end

  test do
    system "true"
  end
end
