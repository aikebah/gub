#
from gub import tools

no_patch = True # let's not use patch in a bootstrap package
class Gzip__tools (tools.AutoBuild):
    source = 'http://ftp.gnu.org/pub/gnu/gzip/gzip-1.3.12.tar.gz'
    patches = ['gzip-1.3.12-glibc-compat.patch']
    if no_patch:
        patches = []
    def patch (self):
        if no_patch:
            for i in ('gzip.c', 'lib/utimens.c', 'lib/utimens.h'):
                self.file_sub ([('(futimens)', r'gz_\1')], '%(srcdir)s/' + i)
        else:
            tools.AutoBuild.patch (self)
