import IndexPage from 'staffApp/pages/IndexPage';
import ClientsPage from 'staffApp/pages/ClientsPage';
import OrganizationsPage from 'staffApp/pages/OrganizationsPage';

export default [
  {
    path: '/', name: 'index', component: IndexPage,
  },
  {
    path: '/organizations', name: 'organizations.index', component: OrganizationsPage,
  },
  {
    path: '/clients', name: 'clients.index', component: ClientsPage,
  },
]
