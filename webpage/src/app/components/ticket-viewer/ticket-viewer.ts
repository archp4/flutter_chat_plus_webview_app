import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

interface Ticket {
  id: string;
  subject: string;
  status: 'Open' | 'In Progress' | 'Closed';
  createdAt: string;
}

@Component({
  selector: 'app-ticket-viewer',
  imports: [CommonModule],
  templateUrl: './ticket-viewer.html',
  styleUrl: './ticket-viewer.css',
})
export class TicketViewer {
  allTickets: Ticket[] = [
    {
      id: 'TKT-001',
      subject: 'Login is not working after most recent update',
      status: 'Open',
      createdAt: '2025-12-01',
    },
    {
      id: 'TKT-002',
      subject: 'Question about new chat feature?',
      status: 'In Progress',
      createdAt: '2025-11-28',
    },
    { id: 'TKT-003', subject: 'Founded new bug', status: 'Closed', createdAt: '2025-11-25' },
    {
      id: 'TKT-004',
      subject: 'Forgot password link not working',
      status: 'Open',
      createdAt: '2025-12-05',
    },
  ];

  filteredTickets: Ticket[] = this.allTickets;
  currentFilter: 'All' | 'Open' | 'In Progress' | 'Closed' = 'All';

  filterTickets(status: 'All' | 'Open' | 'In Progress' | 'Closed'): void {
    this.currentFilter = status;
    if (status === 'All') {
      this.filteredTickets = this.allTickets;
    } else {
      this.filteredTickets = this.allTickets.filter((ticket) => ticket.status === status);
    }
  }
}
