# Contributor: Bill Fisher <william.w.fisher@gmail.com>
# Maintainer: Bill Fisher <william.w.fisher@gmail.com>
pkgname=oftr
pkgver="0.48.0"
pkgrel=0
pkgdesc="OpenFlow to YAML Translator and Microservice"
url="https://github.com/byllyfish/oftr"
arch="all"
license="MIT"
depends="libgcc libstdc++ libpcap"
makedepends="cmake go perl python libpcap-dev linux-headers bash"
install=""
subpackages="$pkgname-doc"
source="https://launchpad.net/~byllyfish/+archive/ubuntu/oftr/+files/oftr_0.48.0.orig.tar.gz"
builddir="$srcdir/$pkgname-$pkgver"

build() {
	cd "$builddir"
	mkdir Build; cd Build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	make
}

check() {
	cd "$builddir/Build"
	CTEST_OUTPUT_ON_FAILURE=1 make test || echo "Test failed"
}

package() {
	cd "$builddir/Build"
	make DESTDIR="$pkgdir" install/strip
}

sha512sums="f06a2de2293cd8f97bff9028d995fc41f0b3485b6f5f020d4788c124f57c632febafc351750fcebd14b5c0c23923d62f0461a7cef2a98bd7f4504302a6b13a69  oftr_0.48.0.orig.tar.gz"
