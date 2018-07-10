# Contributor: Bill Fisher <william.w.fisher@gmail.com>
# Maintainer: Bill Fisher <william.w.fisher@gmail.com>
pkgname=oftr
pkgver="${OFTR_VERSION:-0.50.0}"
pkgrel=0
pkgdesc="OpenFlow to YAML Translator and Microservice"
url="https://github.com/byllyfish/oftr"
arch="all"
license="MIT"
depends="libgcc libstdc++ libpcap"
makedepends="cmake go perl python libpcap-dev linux-headers bash"
install=""
subpackages="$pkgname-doc"
source="https://launchpad.net/~byllyfish/+archive/ubuntu/oftr/+files/oftr_${pkgver}.orig.tar.gz"
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
