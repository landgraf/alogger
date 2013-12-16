Name:		alogger
Version:	0.1
Release:	1%{?dist}
Summary:	Logging framework for application written in Ada

Group:		Development/Libraries
License:	GPLv3+
URL:		http://github.com/landgraf/alogger.git
Source0:	%{name}-%{version}.tar.gz

BuildRequires:	gcc-gnat > 4.8
BuildRequires:  fedora-gnat-project-common > 3
##Requires:	

%description
%{summary}

%package devel
Summary: 	Devel package for %{name}
License:        GPLv3
Group:          Development/Libraries
Requires:	%{name}-%{version}

%description devel
%{summary}

%prep
%setup -q


%build
export FLAGS="%GPRbuild_optflags"
export DEBUG=%{debug}
make %{?_smp_mflags}


%install
make install DESTDIR=%{buildroot} \
prefix=%{_prefix} \
libdir=%{_libdir}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig


%files
%doc
%dir %{_libdir}/%{name}
%{_libdir}/lib%{name}*.so.%{version}
%{_libdir}/%{name}/lib%{name}*.so.%{version}

%files devel
%{_libdir}/lib%{name}*.so.?
%{_libdir}/lib%{name}*.so
%{_libdir}/%{name}/lib%{name}*.so.?
%{_libdir}/%{name}/lib%{name}*.so
%{_libdir}/%{name}/*.ali
%{_includedir}/%{name}
%{_GNAT_project_dir}/%{name}*
%doc


%changelog
* Mon Dec 16 2013 Pavel Zhukov <landgraf@fedoraproject.org> - 2011-1
- Initial build

