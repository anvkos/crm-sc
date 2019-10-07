import IndexPage from 'staffApp/pages/IndexPage';
import ClientsPage from 'staffApp/pages/ClientsPage';
import OrganizationsPage from 'staffApp/pages/OrganizationsPage';
import StaffsPage from 'staffApp/pages/StaffsPage';

export default [
  {
    path: '/', name: 'index', component: IndexPage,
  },
  {
    path: '/organizations', name: 'organizations.index', component: OrganizationsPage,
  },
  {
    path: '/clients', name: 'clients.index', component: ClientsPage,
    children: [
      {
        path: ':id/edit',
        name: 'clients.edit',
        component: () => import('staffApp/components/clients/ClientEdit'),
      },
      {
        path: ':id/organizations',
        name: 'clients.organizations',
        component: () => import('staffApp/components/clients/ClientOrganizations'),
      },
    ],
  },
  {
    path: '/staffs', name: 'staffs.index', component: StaffsPage,
    children: [
      {
        path: ':id/edit',
        name: 'staffs.edit',
        component: () => import('staffApp/components/staffs/StaffEdit'),
      },
    ],
  },
  {
    path: '/equipments', name: 'equipments.index', component: () => import('staffApp/pages/EquipmentPage'),
    children: [
      {
        path: ':id/edit',
        name: 'equipments.edit',
        component: () => import('staffApp/components/equipments/EquipmentEdit'),
      },
    ],
  }
]
