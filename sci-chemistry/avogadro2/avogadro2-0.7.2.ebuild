# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

MY_PN=avogadroapp
MY_P=${MY_PN}-${PV}

DESCRIPTION="Advanced molecule editor and visualizer 2"
HOMEPAGE="http://www.openchemistry.org/"
SRC_URI="mirror://sourceforge/project/avogadro/avogadro2/${PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="BSD GPL-2+"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc rpc test"

RDEPEND="
	>=dev-cpp/eigen-3.2.0-r1
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	~sci-libs/avogadrolibs-${PV}[qt4,opengl]
	sci-libs/hdf5
	rpc? ( sci-chemistry/molequeue )
"
DEPEND="${DEPEND}"

RESTRICT=test

S="${WORKDIR}"/${MY_P}

src_prepare() {
	sed '/COPYING/d' -i CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use rpc Avogadro_ENABLE_RPC)
		$(cmake-utils_use_enable test TESTING)
		)
	cmake-utils_src_configure
}
