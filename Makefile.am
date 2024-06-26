ACLOCAL_AMFLAGS = -I m4

SUBDIRS = data doc include lib po src tests
# Only build GParted help documentation when enabled.  (Can be disabled
# with './configure --disable-doc').
if BUILD_HELP_DOC
  SUBDIRS += help
endif

DESKTOP_IN_IN_FILES = gparted.desktop.in.in
DESKTOP_IN_FILES = gparted.desktop.in
DESKTOP_FILES =$(DESKTOP_IN_FILES:.desktop.in=.desktop)
desktopdir = $(datadir)/applications
desktop_DATA = $(DESKTOP_FILES)

$(DESKTOP_FILES): $(DESKTOP_IN_FILES)
	$(AM_V_GEN)$(MSGFMT) --desktop --template $< -d $(top_srcdir)/po -o $@

APPDATA_IN_FILES = gparted.appdata.xml.in
APPDATA_FILES =$(APPDATA_IN_FILES:.xml.in=.xml)
appdatadir = $(datadir)/appdata
appdata_DATA = $(APPDATA_FILES)

$(APPDATA_FILES): $(APPDATA_IN_FILES)
	$(AM_V_GEN)$(MSGFMT) --xml --template $< -d $(top_srcdir)/po -o $@

polkit_action_in_in_FILES = org.gnome.gparted.policy.in.in
polkit_action_in_FILES = org.gnome.gparted.policy.in
polkit_action_FILES = $(polkit_action_in_FILES:.policy.in=.policy)

$(polkit_action_FILES): $(polkit_action_in_FILES)
	$(AM_V_GEN)$(MSGFMT) --xml --template $< -d $(top_srcdir)/po -o $@

polkit_actiondir = $(datadir)/polkit-1/actions
if INSTALL_POLKIT_ACTIONS
  polkit_action_DATA = $(polkit_action_FILES)
endif

bin_SCRIPTS = gparted
CLEANFILES = $(bin_SCRIPTS) $(DESKTOP_IN_FILES) $(polkit_action_in_FILES)

do_subst = sed -e 's,[@]libexecdir[@],$(libexecdir),g' \
	-e 's,[@]bindir[@],$(bindir),g' \
	-e 's,[@]gksuprog[@],$(GKSUPROG),g' \
	-e 's,[@]enable_xhost_root[@],$(ENABLE_XHOST_ROOT),g'

gparted.desktop.in:  gparted.desktop.in.in Makefile
	$(do_subst) < $(srcdir)/gparted.desktop.in.in > gparted.desktop.in

gparted:  gparted.in Makefile
	$(do_subst) < $(srcdir)/gparted.in > gparted
	chmod +x gparted

org.gnome.gparted.policy.in: org.gnome.gparted.policy.in.in Makefile
	$(do_subst) < $(srcdir)/org.gnome.gparted.policy.in.in > org.gnome.gparted.policy.in

dist-hook:
	@if test -d "$(srcdir)/.git"; \
	then \
		echo Creating ChangeLog && \
		( cd "$(top_srcdir)" && \
		  echo '# Generated by Makefile. Do not edit.'; echo; \
		  $(top_srcdir)/missing --run \
		  git log GPARTED_0_4_4.. --date-order --date=short | \
		  sed -e '/^commit.*$$/d' | \
		  awk '/^Author/ {sub(/\\$$/,""); getline t; print $$0 t; next}; 1' | \
		  sed -e 's/^Author: //g' | \
		  sed -e 's/>Date:   \([0-9]*-[0-9]*-[0-9]*\)/>\t\1/g' | \
		  sed -e 's/^\([^\t<]*[<][^\t>]*>\)\t\([^\t]*\)/\2  \1/g'; \
		  echo; \
		) > ChangeLog.tmp \
		&& cat $(top_srcdir)/ChangeLog >> ChangeLog.tmp \
		&& mv -f ChangeLog.tmp $(top_distdir)/ChangeLog \
		|| ( rm -f ChangeLog.tmp ; \
		     echo Failed to generate ChangeLog >&2 ); \
	else \
		echo A git clone is required to generate a ChangeLog >&2; \
	fi

EXTRA_DIST =			\
	$(APPDATA_IN_FILES)	\
	$(APPDATA_FILES)	\
	$(DESKTOP_IN_IN_FILES)	\
	$(DESKTOP_FILES)	\
	$(polkit_action_in_in_FILES)  \
	gparted.in

DISTCLEANFILES =		\
	$(appdata_DATA)		\
	$(desktop_DATA)		\
	$(polkit_action_DATA)
