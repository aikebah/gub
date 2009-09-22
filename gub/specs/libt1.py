from gub import target
from gub import tools

class Libt1 (target.AutoBuild):
    source = 'ftp://sunsite.unc.edu/pub/Linux/libs/graphics/t1lib-5.1.2.tar.gz'
    parallel_build_broken = True
    srcdir_build_broken = True
    def _get_build_dependencies (self):
        return [
            'tools::libtool',
            ]
    def makeflags (self):
        return ''' without_doc 'VPATH:=$(srcdir)' '''

class Libt1__tools (tools.AutoBuild, Libt1):
    parallel_build_broken = True
    srcdir_build_broken = True
    def _get_build_dependencies (self):
        return [
            'libtool',
            ]
