class LibopenmptAT4 < Formula
  desc "Software library to decode tracked music files"
  homepage "https://lib.openmpt.org/libopenmpt/"
  url "https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-0.4.30+release.autotools.tar.gz"
  version "0.4.30"
  sha256 "3085eb09155c14a1782c88e5459f347230d69dc5e1694f043a9b57d9214e7312"
  license "BSD-3-Clause"

  keg_only :versioned_formula

  depends_on "pkg-config" => :build

  depends_on "flac"
  depends_on "libogg"
  depends_on "libsndfile"
  depends_on "libvorbis"
  depends_on "mpg123"

  def install
    ENV["MACOSX_DEPLOYMENT_TARGET"] = "10.9"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--without-vorbisfile",
                          "--disable-openmpt123",
                          "--disable-examples",
                          "--disable-tests",
                          "--disable-doxygen-doc",
                          "--without-portaudio",
                          "--without-portaudiocpp"

    system "make"
    system "make", "install"
  end

  test do
    system "true"
  end
end
