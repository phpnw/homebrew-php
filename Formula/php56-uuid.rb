require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Uuid < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/uuid"
  url "https://pecl.php.net/get/uuid-1.0.3.tgz"
  sha256 "6832c6453efec9800d2dc0bb9786cea02888378e88c15851f79210ef78369ef1"
  head "https://svn.php.net/repository/pecl/uuid/trunk"

  stable do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/4ad7ebf2bff53887f64ac5be802b85ea5856fa85/php-uuid.patch"
      sha1 "274dfb222ee214a876b2e5bd070b711ce79fd859"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "2c0436c14e40fe4d7dfef3b615c57134dbf8dbe3402b99a507eed5e848094783" => :el_capitan
    sha256 "3ce6819f1bc245e25d7a2cbf04bf2f92183f509a3edf57df985268091fa12532" => :yosemite
    sha256 "ad05ab099106a89314f9674f2d8bee62f9b3820ad739d60b624f090369c58740" => :mavericks
  end

  head do
    patch do
      url "https://gist.github.com/phoenixsong6/4958223/raw/e802b0e6daebb4403dc77c81e149c5f8c8f49b7e/php-uuid-trunk.patch"
      sha1 "b5fbab7574cf035d318fd932ea5bd4bca0aa44e9"
    end
  end

  def install
    Dir.chdir "uuid-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uuid.so"
    write_config_file if build.with? "config-file"
  end
end
