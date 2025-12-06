import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LogsPanel } from './logs-panel';

describe('LogsPanel', () => {
  let component: LogsPanel;
  let fixture: ComponentFixture<LogsPanel>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LogsPanel]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LogsPanel);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
