class Libadlmidi < Formula
  desc "Software MIDI Synthesizer library with OPL3 (YMF262) emulator (static lib)"
  homepage "https://github.com/Wohlstand/libADLMIDI"
  url "https://github.com/Wohlstand/libADLMIDI/archive/refs/tags/v1.5.0.1-1.tar.gz"
  sha256 "f19b18f35564f4db6f5d35d820655ea48e2cf8ffb193037fad74eecbabb35f07"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.1-or-later", "MIT"]
  head "https://github.com/Wohlstand/libADLMIDI.git"

  depends_on "cmake" => :build
  depends_on "zita-resampler"

  def install
    ENV["MACOSX_DEPLOYMENT_TARGET"] = "10.9"
    ENV.prepend "CFLAGS", "-I/usr/local/include"
    ENV.prepend "CXXFLAGS", "-I/usr/local/include"

    args = std_cmake_args + %w[
      -DlibADLMIDI_SHARED=OFF
      -DlibADLMIDI_STATIC=ON
      -DWITH_MIDI_SEQUENCER=ON
      -DWITH_EMBEDDED_BANKS=OFF
      -DWITH_HQ_RESAMPLER=ON
      -DWITH_MUS_SUPPORT=ON
      -DWITH_XMI_SUPPORT=ON
      -DUSE_DOSBOX_EMULATOR=ON
      -DUSE_NUKED_EMULATOR=ON
      -DUSE_OPAL_EMULATOR=OFF
      -DUSE_JAVA_EMULATOR=OFF
      -DWITH_GENADLDATA=OFF
      -DWITH_GENADLDATA_COMMENTS=OFF
      -DWITH_MIDIPLAY=OFF
      -DWITH_ADLMIDI2=OFF
      -DWITH_VLC_PLUGIN=OFF
      -DWITH_OLD_UTILS=OFF
      -DWITH_MUS2MID=OFF
      -DWITH_XMI2MID=OFF
      -DEXAMPLE_SDL2_AUDIO=OFF
    ]

    mkdir "build" do
      system "cmake", "..", *args
      inreplace "libADLMIDI.pc", "-lADLMIDI", "-lADLMIDI -lzita-resampler"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
