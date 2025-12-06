import { Routes } from '@angular/router';
import { TicketViewer } from './components/ticket-viewer/ticket-viewer';
import { Editor } from './components/editor/editor';
import { LogsPanel } from './components/logs-panel/logs-panel';

export const routes: Routes = [
  {
    path: 'tickets',
    component: TicketViewer,
  },
  {
    path: 'editor',
    component: Editor,
  },

  {
    path: 'logs',
    component: LogsPanel,
  },
  { path: '', redirectTo: '/tickets', pathMatch: 'full' },
];
