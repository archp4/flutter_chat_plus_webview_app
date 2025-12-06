import {
  Component,
  NgZone,
  OnInit,
  OnDestroy,
  AfterViewInit,
  ViewChild,
  ElementRef,
  ChangeDetectorRef,
} from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-logs-panel',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './logs-panel.html',
  styleUrl: './logs-panel.css',
})
export class LogsPanel implements OnInit, OnDestroy, AfterViewInit {
  constructor(private ngZone: NgZone, private cdRef: ChangeDetectorRef) {}
  ngAfterViewInit(): void {
    this.scrollToBottom();
  }
  @ViewChild('logsContainer') private logsContainer!: ElementRef;

  logs: string[] = [];
  logInterval: any;
  logMessages = [
    '[INFO] User TKT-004 request received.',
    '[WARN] Database connection slow (345ms).',
    '[ERROR] Knowledgebase editor save failed for ID 403.',
    "[DEBUG] Agent 'Alice' logged in.",
    "[INFO] Ticket TKT-002 status updated to 'Closed'.",
  ];

  ngOnInit(): void {
    this.startLogSimulation();
  }

  ngOnDestroy(): void {
    clearInterval(this.logInterval);
  }

  startLogSimulation(): void {
    console.log('Starting log simulation...');
    this.logInterval = this.ngZone.run(() =>
      setInterval(() => {
        const randomIndex = Math.floor(Math.random() * this.logMessages.length);
        const randomMessage = this.logMessages[randomIndex];
        const timestamp = new Date().toLocaleTimeString('en-US');

        this.logs.push(`[${timestamp}] ${randomMessage}`);

        if (this.logs.length > 100) {
          this.logs.shift();
        }
        this.cdRef.detectChanges();
        this.scrollToBottom();
      }, 1500)
    );
  }

  scrollToBottom(): void {
    try {
      setTimeout(() => {
        this.logsContainer.nativeElement.scrollTop = this.logsContainer.nativeElement.scrollHeight;
      }, 0);
    } catch (err) {
      console.error('Scroll to bottom failed:', err);
    }
  }
}
