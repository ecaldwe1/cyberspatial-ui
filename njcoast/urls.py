from django.conf.urls import patterns, url
from django.views.generic import TemplateView

from geonode.urls import *

urlpatterns = patterns('',
                       url(r'^/?$', TemplateView.as_view(template_name='site_index.html'), name='home'),
                       url(r'^about/$', TemplateView.as_view(template_name='site_about.html'), name='about'),
                       url(r'^maps/$', TemplateView.as_view(template_name='map.html'), name='maps_browse'),
                       ) + urlpatterns
