import IndexPage from 'staffApp/pages/IndexPage';
import ClientsPage from 'staffApp/pages/ClientsPage';
import ClientEdit from 'staffApp/pages/ClientEdit';
import OrganizationsPage from 'staffApp/pages/OrganizationsPage';
import StaffsPage from 'staffApp/pages/StaffsPage';
import StaffEdit from 'staffApp/pages/StaffEdit';

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
        path: ':id/edit', name: 'clients.edit',
        components: {
          default: ClientsPage,
          modal: ClientEdit,
        },
        props: true,
        meta: {
          showModal: true
        }
      },
    ],
  },
  {
    path: '/staffs', name: 'staffs.index', component: StaffsPage,
    children: [
      {
        path: ':id/edit', name: 'staffs.edit',
        components: {
          default: StaffsPage,
          modal: StaffEdit,
        },
        props: true,
        meta: {
          showModal: true
        }
      },
    ],
  },
  {
    path: '/equipments', name: 'equipments.index', component: () => import('staffApp/pages/EquipmentPage'),
  }
]
